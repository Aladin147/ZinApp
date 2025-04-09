import { API_BASE_URL, API_BASE_URLS, API_ENDPOINTS } from '@constants';
import { Stylist, Service, Booking, User, Rating } from '@types';

// Helper function to try fetching from multiple API URLs
async function fetchWithFallbackUrls(endpoint: string, options: RequestInit = {}): Promise<Response> {
  // Try each URL in sequence until one works
  let lastError: Error | null = null;

  for (const baseUrl of API_BASE_URLS) {
    try {
      const url = `${baseUrl}${endpoint}`;
      console.log(`Attempting to fetch from: ${url}`);

      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 3000); // Shorter timeout for faster fallback

      const response = await fetch(url, {
        ...options,
        signal: controller.signal
      });

      clearTimeout(timeoutId);

      if (response.ok) {
        console.log(`Successfully connected to ${baseUrl}`);
        return response;
      }
    } catch (error) {
      console.log(`Failed to connect to ${baseUrl}:`, error);
      lastError = error as Error;
      // Continue to the next URL
    }
  }

  // If we get here, all URLs failed
  throw lastError || new Error('All API URLs failed');
}

// Fallback mock data for when the API server is unreachable
const FALLBACK_DATA = {
  users: [
    {
      id: 10,
      name: "Yassine",
      is_verified: true,
      trust_score: 87,
      payment_methods: ["card", "cash"],
      favorite_stylists: [1],
      qr_discovery: true
    }
  ],
  stylists: [
    {
      id: 1,
      name: "Hassan the Barber",
      rating: 4.9,
      distance_km: 2.1,
      verified: true,
      bio: "Fade specialist, 10+ yrs experience",
      services: [1, 2, 4],
      gallery: ["/img/fade1.jpg", "/img/fade2.jpg"],
      availability: "09:00 - 19:00",
      location: { lat: 33.5899, lng: -7.6039 },
      profile_picture: "/img/hassan.png",
      qr_link: "/barber/hassan"
    }
  ],
  services: [
    { id: 1, name: "Haircut", price: 50 },
    { id: 2, name: "Beard Trim", price: 30 },
    { id: 3, name: "Braids", price: 70 },
    { id: 4, name: "Full Service", price: 100 }
  ],
  bookings: [
    {
      id: 101,
      user_id: 10,
      stylist_id: 1,
      service_id: 1,
      status: "confirmed",
      datetime: "2025-04-10T14:30:00Z",
      payment_method: "card",
      rating_given: false
    }
  ],
  ratings: [
    {
      id: 201,
      stylist_id: 1,
      user_id: 10,
      stars: 5,
      comment: "Clean fade, came fast.",
      timestamp: "2025-04-05T16:00:00Z"
    }
  ]
};

/**
 * API service for ZinApp
 * Provides methods to interact with the mock API server
 */
class ApiService {
  /**
   * Fetch all stylists
   */
  async getAllStylists(): Promise<Stylist[]> {
    try {
      // Use the fetchWithFallbackUrls helper to try multiple API URLs
      const response = await fetchWithFallbackUrls(API_ENDPOINTS.STYLISTS);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching stylists:', error);
      console.log('Using fallback stylist data');
      return FALLBACK_DATA.stylists;
    }
  }

  /**
   * Fetch a stylist by ID
   */
  async getStylistById(id: number): Promise<Stylist | null> {
    try {
      // Use the fetchWithFallbackUrls helper to try multiple API URLs
      const response = await fetchWithFallbackUrls(`${API_ENDPOINTS.STYLISTS}/${id}`);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching stylist with ID ${id}:`, error);

      // Return fallback data if available
      const fallbackStylist = FALLBACK_DATA.stylists.find(stylist => stylist.id === id);
      if (fallbackStylist) {
        console.log(`Using fallback data for stylist ${id}`);
        return fallbackStylist;
      }

      return null;
    }
  }

  /**
   * Fetch all services
   */
  async getAllServices(): Promise<Service[]> {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000);

      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.SERVICES}`, { signal: controller.signal });
      clearTimeout(timeoutId);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching services:', error);
      console.log('Using fallback service data');
      return FALLBACK_DATA.services;
    }
  }

  /**
   * Fetch a service by ID
   */
  async getServiceById(id: number): Promise<Service | null> {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000);

      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.SERVICES}/${id}`, { signal: controller.signal });
      clearTimeout(timeoutId);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching service with ID ${id}:`, error);

      // Return fallback data if available
      const fallbackService = FALLBACK_DATA.services.find(service => service.id === id);
      if (fallbackService) {
        console.log(`Using fallback data for service ${id}`);
        return fallbackService;
      }

      return null;
    }
  }

  /**
   * Create a new booking
   */
  async createBooking(booking: Omit<Booking, 'id'>): Promise<Booking | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(booking),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error creating booking:', error);
      return null;
    }
  }

  /**
   * Fetch all bookings for a user
   */
  async getUserBookings(userId: number): Promise<Booking[]> {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000);

      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}?user_id=${userId}`, { signal: controller.signal });
      clearTimeout(timeoutId);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching bookings for user ${userId}:`, error);

      // Return fallback bookings for this user
      const fallbackBookings = FALLBACK_DATA.bookings.filter(booking => booking.user_id === userId);
      if (fallbackBookings.length > 0) {
        console.log(`Using fallback bookings data for user ${userId}`);
        return fallbackBookings;
      }

      return [];
    }
  }

  /**
   * Get a booking by ID
   */
  async getBookingById(id: number): Promise<Booking | null> {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000);

      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}/${id}`, { signal: controller.signal });
      clearTimeout(timeoutId);

      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching booking with ID ${id}:`, error);

      // Return fallback data if available
      const fallbackBooking = FALLBACK_DATA.bookings.find(booking => booking.id === id);
      if (fallbackBooking) {
        console.log(`Using fallback data for booking ${id}`);
        return fallbackBooking;
      }

      return null;
    }
  }

  /**
   * Update a booking
   */
  async updateBooking(id: number, updates: Partial<Booking>): Promise<Booking | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}/${id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updates),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error updating booking with ID ${id}:`, error);
      return null;
    }
  }

  /**
   * Get user by ID
   */
  async getUserById(id: number): Promise<User | null> {
    console.log(`[getUserById] Attempting to fetch user with ID: ${id}`);

    try {
      // Use the fetchWithFallbackUrls helper to try multiple API URLs
      const response = await fetchWithFallbackUrls(`${API_ENDPOINTS.USERS}/${id}`);

      console.log(`[getUserById] Fetch response received. Status: ${response.status}, OK: ${response.ok}`);

      // Parse JSON directly
      const data = await response.json();
      console.log(`[getUserById] JSON parsed successfully for user ${id}`);
      return data;
    } catch (error) {
      console.error(`[getUserById] Error fetching or processing user with ID ${id}:`, error);

      if (error instanceof TypeError) {
        console.error("[getUserById] Caught TypeError specifically.");
      }

      // Return fallback data if available
      const fallbackUser = FALLBACK_DATA.users.find(user => user.id === id);
      if (fallbackUser) {
        console.log(`[getUserById] Using fallback data for user ${id}`);
        return fallbackUser;
      }

      return null;
    }
  }

  /**
   * Submit a rating
   */
  async submitRating(rating: Omit<Rating, 'id'>): Promise<Rating | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.RATINGS}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(rating),
      });
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error submitting rating:', error);
      return null;
    }
  }

  /**
   * Get ratings for a stylist
   */
  async getStylistRatings(stylistId: number): Promise<Rating[]> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.RATINGS}?stylist_id=${stylistId}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching ratings for stylist ${stylistId}:`, error);
      return [];
    }
  }
}

// Export a singleton instance
const apiService = new ApiService();
export default apiService;

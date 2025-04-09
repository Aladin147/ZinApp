import { API_BASE_URL, API_ENDPOINTS } from '@constants';
import { Stylist, Service, Booking, User, Rating } from '@types';

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
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.STYLISTS}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching stylists:', error);
      return [];
    }
  }

  /**
   * Fetch a stylist by ID
   */
  async getStylistById(id: number): Promise<Stylist | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.STYLISTS}/${id}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching stylist with ID ${id}:`, error);
      return null;
    }
  }

  /**
   * Fetch all services
   */
  async getAllServices(): Promise<Service[]> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.SERVICES}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching services:', error);
      return [];
    }
  }

  /**
   * Fetch a service by ID
   */
  async getServiceById(id: number): Promise<Service | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.SERVICES}/${id}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching service with ID ${id}:`, error);
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
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}?user_id=${userId}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching bookings for user ${userId}:`, error);
      return [];
    }
  }

  /**
   * Get a booking by ID
   */
  async getBookingById(id: number): Promise<Booking | null> {
    try {
      const response = await fetch(`${API_BASE_URL}${API_ENDPOINTS.BOOKINGS}/${id}`);
      const data = await response.json();
      return data;
    } catch (error) {
      console.error(`Error fetching booking with ID ${id}:`, error);
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
    const url = `${API_BASE_URL}${API_ENDPOINTS.USERS}/${id}`;
    console.log(`[getUserById] Attempting to fetch: ${url}`); // Log before fetch
    try {
      const response = await fetch(url);
      console.log(`[getUserById] Fetch response received. Status: ${response.status}, OK: ${response.ok}`); // Log after fetch resolves

      // Check if the response was successful
      if (!response.ok) {
        // Log the error status and potentially the response text
        const errorText = await response.text(); // Read response text if not JSON
        console.error(`Error fetching user ${id}: ${response.status} ${response.statusText}`, errorText);
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      // Log the raw text response before parsing JSON
      const responseText = await response.text();
      console.log(`[getUserById] Raw response for user ${id}:`, responseText.substring(0, 100) + '...'); // Log truncated text
      
      // Now try parsing the logged text
      const data = JSON.parse(responseText); 
      console.log(`[getUserById] JSON parsed successfully for user ${id}`);
      return data;
    } catch (error) {
      console.error(`[getUserById] Error fetching or processing user with ID ${id}:`, error); // Enhanced error log
      // Log the specific type of error if possible
      if (error instanceof TypeError) {
        console.error("[getUserById] Caught TypeError specifically.");
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

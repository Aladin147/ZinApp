// Global app types

// Stylist type based on mock API schema
export interface Stylist {
  id: number;
  name: string;
  rating: number;
  distance_km: number;
  verified: boolean;
  bio: string;
  services: number[];
  gallery: string[];
  availability: string;
  location: {
    lat: number;
    lng: number;
  };
  profile_picture: string;
  qr_link: string;
}

// Service type
export interface Service {
  id: number;
  name: string;
  price: number;
}

// Booking type
export interface Booking {
  id: number;
  user_id: number;
  stylist_id: number;
  service_id: number;
  status: 'confirmed' | 'en_route' | 'arrived' | 'completed' | 'canceled';
  datetime: string;
  payment_method: 'card' | 'cash';
  rating_given: boolean;
}

// User type
export interface User {
  id: number;
  name: string;
  is_verified: boolean;
  trust_score: number;
  payment_methods: ('card' | 'cash')[];
  favorite_stylists: number[];
  qr_discovery: boolean;
}

// Rating type
export interface Rating {
  id: number;
  stylist_id: number;
  user_id: number;
  stars: number;
  comment: string;
  timestamp: string;
}

// Navigation parameter types
export type RootStackParamList = {
  LandingScreen: undefined;
  ServiceSelectScreen: undefined;
  StylistListScreen: { serviceId?: number };
  BarberProfileScreen: { stylistId: number; qrSource?: boolean };
  BookingScreen: { stylistId: number; serviceId: number };
  LiveTrackScreen: { bookingId: number };
  Bsse7aScreen: { bookingId: number };
  LogoShowcaseScreen: undefined;
  AvatarShowcaseScreen: undefined;
  QRScannerShowcaseScreen: undefined;
  TypographyShowcaseScreen: undefined;
};

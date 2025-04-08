// Demo flag constants from STATE_FLAGS.md

// Define the flag types
type FlagName = 'qr_discovery' | 'is_verified' | 'rating_given' | 'fast_book' | 'no_stylists';

// Define the interface for our flags object
interface Flags {
  // Demo flags
  qr_discovery: boolean; // Adds trust glow + fast CTA on BarberProfile screen
  is_verified: boolean;  // Enables cash payment on Booking/Payment screens
  rating_given: boolean; // Controls review modal display on Bsse7aScreen
  fast_book: boolean;    // Skips profile and goes direct to booking from StylistList
  no_stylists: boolean;  // Triggers empty state screen on StylistList

  // Helper functions
  toggleFlag: (flagName: FlagName) => boolean;
  setFlag: (flagName: FlagName, value: boolean) => void;
}

// Create and export the flags object
const flags: Flags = {
  // Initialize demo flags
  qr_discovery: false,
  is_verified: false,
  rating_given: false,
  fast_book: false,
  no_stylists: false,

  // Helper function to toggle flags in development
  toggleFlag: (flagName: FlagName): boolean => {
    if (flagName in flags && typeof flags[flagName as keyof Flags] === 'boolean') {
      // @ts-ignore - we're explicitly checking if it's a boolean above
      flags[flagName] = !flags[flagName];
      // @ts-ignore - same reason
      return flags[flagName];
    }
    return false;
  },

  // Helper to set a specific flag value
  setFlag: (flagName: FlagName, value: boolean): void => {
    if (flagName in flags && typeof flags[flagName as keyof Flags] === 'boolean') {
      // @ts-ignore - we're explicitly checking if it's a boolean above
      flags[flagName] = value;
    }
  }
};

export default flags;

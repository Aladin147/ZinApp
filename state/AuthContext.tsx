import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { User } from '@types';
// apiService import removed for DEMO MODE
// import apiService from '@services/api';
// DEFAULT_USER_ID import removed for DEMO MODE
// import { DEFAULT_USER_ID } from '@constants';
import flags from '@constants/flags';

// Define the context state
interface AuthContextType {
  user: User | null;
  isLoading: boolean;
  isVerified: boolean;
  error: string | null;
  login: (userId: number) => Promise<void>;
  logout: () => void;
  toggleVerifiedState: () => void;
}

// Create context with default values
const AuthContext = createContext<AuthContextType>({
  user: null,
  isLoading: false,
  isVerified: false,
  error: null,
  login: async () => {},
  logout: () => {},
  toggleVerifiedState: () => {},
});

// Provider component
export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [isVerified, setIsVerified] = useState<boolean>(false);

  // DEMO MODE: Hardcoded user data to bypass API completely
  // This ensures the app works even when API is completely unavailable
  const hardcodedUser: User = {
    id: 10,
    name: "Yassine",
    is_verified: true,
    trust_score: 87,
    payment_methods: ["card", "cash"],
    favorite_stylists: [1],
    qr_discovery: true
  };

  // Auto-login with hardcoded user for demonstration
  useEffect(() => {
    // Simulate a brief loading state for UI consistency
    setTimeout(() => {
      console.log('DEMO MODE: Using hardcoded user data');
      setUser(hardcodedUser);
      setIsVerified(hardcodedUser.is_verified);
      flags.setFlag('is_verified', hardcodedUser.is_verified);
      setIsLoading(false);
    }, 500);
  }, []);

  // Login function - DEMO MODE: Always uses hardcoded user
  const login = async (userId: number) => {
    setIsLoading(true);
    setError(null);

    // Simulate API call with timeout
    setTimeout(() => {
      console.log(`DEMO MODE: Login successful with hardcoded user (requested ID: ${userId})`);
      // In demo mode, we always return the same user regardless of ID
      // In a real app, we would fetch the user with the specified ID
      setUser(hardcodedUser);
      setIsVerified(hardcodedUser.is_verified);
      flags.setFlag('is_verified', hardcodedUser.is_verified);
      setIsLoading(false);
    }, 800);
  };

  // Logout function
  const logout = () => {
    setUser(null);
    setIsVerified(false);
    flags.setFlag('is_verified', false);
  };

  // Toggle verified state (for demo purposes)
  const toggleVerifiedState = () => {
    const newVerifiedState = !isVerified;
    setIsVerified(newVerifiedState);
    flags.setFlag('is_verified', newVerifiedState);

    if (user) {
      setUser({
        ...user,
        is_verified: newVerifiedState,
        payment_methods: newVerifiedState
          ? ['card', 'cash']
          : ['card']
      });
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        isLoading,
        isVerified,
        error,
        login,
        logout,
        toggleVerifiedState,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

// Custom hook for using the auth context
export const useAuth = () => useContext(AuthContext);

export default AuthContext;

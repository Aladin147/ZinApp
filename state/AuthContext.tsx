import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { User } from '@types';
import apiService from '@services/api';
import { DEFAULT_USER_ID } from '@constants';
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

  // Auto-login with default user for demonstration
  useEffect(() => {
    const loadDefaultUser = async () => {
      try {
        const userData = await apiService.getUserById(DEFAULT_USER_ID);
        if (userData) {
          setUser(userData);
          setIsVerified(userData.is_verified || false);
          // Sync with flag system
          flags.setFlag('is_verified', userData.is_verified || false);
        }
      } catch (err) {
        setError('Failed to load default user');
        console.error(err);
      } finally {
        setIsLoading(false);
      }
    };

    loadDefaultUser();
  }, []);

  // Login function
  const login = async (userId: number) => {
    setIsLoading(true);
    setError(null);
    
    try {
      const userData = await apiService.getUserById(userId);
      if (userData) {
        setUser(userData);
        setIsVerified(userData.is_verified || false);
        // Sync with flag system
        flags.setFlag('is_verified', userData.is_verified || false);
      } else {
        setError('User not found');
      }
    } catch (err) {
      setError('Authentication failed');
      console.error(err);
    } finally {
      setIsLoading(false);
    }
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

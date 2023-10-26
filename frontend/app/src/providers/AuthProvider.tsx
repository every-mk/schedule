import { useState, createContext, Dispatch, SetStateAction, ReactNode } from "react";

import { Auth } from "../types/api/auth";

export type AuthContextType = {
  auth: Auth | null;
  setAuth: Dispatch<SetStateAction<Auth | null>>;
}

export const AuthContext = createContext<AuthContextType>({
  auth: null
} as AuthContextType);

export const AuthProvider = (props: { children: ReactNode }) => {
  const { children } = props;
  const [auth, setAuth] = useState<Auth | null>(null)

  return (
    <AuthContext.Provider value={{ auth, setAuth }}>
      {children}
    </AuthContext.Provider>
  );
};

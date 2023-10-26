import { useState, createContext, Dispatch, SetStateAction, ReactNode } from "react";

import { Auth } from "../types/api/auth";

export type AuthContextType = {
  auth: Auth | null;
  config: {};
  setAuth: Dispatch<SetStateAction<Auth | null>>;
}

export const AuthContext = createContext<AuthContextType>({
  auth: null,
  config: {}
} as AuthContextType);

export const AuthProvider = (props: { children: ReactNode }) => {
  const { children } = props;
  const [auth, setAuth] = useState<Auth | null>(null)
  const config = {
    headers: {
      contentType: "application/json",
      ["access-token"]: auth?.["access-token"],
      client: auth?.client,
      uid: auth?.uid
    }
  };

  return (
    <AuthContext.Provider value={{ auth, config, setAuth }}>
      {children}
    </AuthContext.Provider>
  );
};

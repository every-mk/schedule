import { useState, createContext, Dispatch, SetStateAction, ReactNode } from "react";

import { User } from "../types/user";

export type LoginUserContextType = {
  loginUser: User | null;
  setLoginUser: Dispatch<SetStateAction<User | null>>;
}

export const LoginUserContext = createContext<LoginUserContextType>({
  loginUser: null
} as LoginUserContextType);

export const LoginUserProvider = (props: { children: ReactNode })  => {
  const { children } = props;
  const [loginUser, setLoginUser] = useState<User | null>(null)

  return (
    <LoginUserContext.Provider value={{ loginUser, setLoginUser }}>
      {children}
    </LoginUserContext.Provider>
  );
};

import { ChangeEvent, useState, FC, useCallback, useContext } from "react";
import { BrowserRouter } from "react-router-dom";

import { HeaderLayout } from "./components/templates/HeaderLayout";
import { Router } from "./router/Router";
import { LoginUserProvider } from "./providers/LoginUserProvider";
import { AuthProvider } from "./providers/AuthProvider";

export const App: FC = () => {
  return (
    <BrowserRouter>
      <AuthProvider>
        <LoginUserProvider>
          <HeaderLayout>
            <Router />
          </HeaderLayout>
        </LoginUserProvider>
      </AuthProvider>
    </BrowserRouter>
  );
};

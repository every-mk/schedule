import { memo, FC } from "react";
import { Route, Routes } from "react-router-dom";

import { Home } from "../components/pages/Home";
import { Login } from "../components/pages/Login";
import { homeRoutes } from "./HomeRoutes"
import { Page404 } from "../components/pages/Page404";
import { RegisterRoutes } from "./RegisterRoutes";
import { accountRoutes } from "./AccountRoutes";

export const Router: FC = memo(() => {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/login" element={<Login />} />
      <Route path="/home">
        {homeRoutes.map((route, index) => (
          index === 0
            ? <Route index key={route.path} element={route.children} />
            : <Route key={route.path} path={route.path} element={route.children} /> 
        ))}
      </Route>
      <Route path="/register">
        {RegisterRoutes.map((route, index) => (
          index === 0
            ? <Route index key={route.path} element={route.children} />
            : <Route key={route.path} path={route.path} element={route.children} />
        ))}
      </Route>
      <Route path="account">
        {accountRoutes.map((route, index) => (
          index === 0
            ? <Route index key={route.path} element={route.children} />
            : <Route key={route.path} path={route.path} element={route.children} />
        ))}
      </Route>
      <Route path="*" element={<Page404 />} />
    </Routes>
  );
});

import { memo, FC } from "react";
import { Route, Routes } from "react-router-dom";

import { Login } from "../components/pages/Login";
import { homeRoutes } from "./HomeRoutes"
import { Page404 } from "../components/pages/Page404";

export const Router: FC = memo(() => {
  return (
    <Routes>
      <Route path="/" element={<Login/>} />
      <Route path="/home">
        {homeRoutes.map((route, index) => (
          index === 0
            ? <Route index element={route.children} />
            : <Route path={route.path} element={route.children} /> 
        ))}
      </Route>
      <Route path="*" element={<Page404 />} />
    </Routes>
  );
});

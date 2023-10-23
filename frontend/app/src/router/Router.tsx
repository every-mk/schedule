import { memo, FC } from "react";
import { Route, Routes } from "react-router-dom";

import { Login } from "../components/pages/Login";
import { homeRoutes } from "./HomeRoutes"
import { Page404 } from "../components/pages/Page404";
import { HeaderLayout } from "../components/templates/HeaderLayout";

export const Router: FC = memo(() => {
  return (
    <Routes>
      <Route path="/" element={<Login/>} />
      <Route path="/home">
        {homeRoutes.map((route, index) => (
          index === 0
            ? <Route index element={<HeaderLayout>{route.children}</HeaderLayout>} />
            : <Route path={route.path} element={<HeaderLayout>{route.children}</HeaderLayout>} /> 
        ))}
      </Route>
      <Route path="*" element={<Page404 />} />
    </Routes>
  );
});

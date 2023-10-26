import { Home } from "../components/pages/Home";
import { UserManagement } from "../components/pages/UserManagement";

export const homeRoutes = [
  {
    path: "/",
    children: <Home />
  },
  {
    path: "user_management",
    children: <UserManagement />
  },
];

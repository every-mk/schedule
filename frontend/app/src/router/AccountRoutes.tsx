import { Account } from "../components/pages/Account";
import { NameEdite } from "../components/pages/NameEdite";
import { PasswordEdite } from "../components/pages/PasswordEdite";

export const accountRoutes = [
  {
    path: "/",
    children: <Account />
  },
  {
    path: "nameEdite",
    children: <NameEdite />
  },
  {
    path: "passwordEdite",
    children: <PasswordEdite />
  },
]

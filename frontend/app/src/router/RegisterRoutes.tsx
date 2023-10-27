import { Signup } from "../components/pages/Signup";
import { SignupConfirm } from "../components/pages/SignupConfirm";

export const RegisterRoutes = [
  {
    path: "/",
    children: <Signup />
  },
  {
    path: "signupConfirm",
    children: <SignupConfirm />
  }
]

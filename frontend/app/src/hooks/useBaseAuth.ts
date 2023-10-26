import { useContext } from "react";

import { AuthContext, AuthContextType } from "../providers/AuthProvider";

export const useBaseAuth = (): AuthContextType => useContext(AuthContext);

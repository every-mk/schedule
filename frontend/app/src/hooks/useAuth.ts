import { useCallback } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

import { useLoginUser } from "./useLoginUser";
import { Auth } from "../types/api/auth";
import { useBaseAuth } from "./useBaseAuth";

export const useAuth = () => {
  const navigate = useNavigate();
  const { setLoginUser } = useLoginUser();
  const { config, setAuth } = useBaseAuth();

  const login = useCallback((email: string, password: string) => {
    axios.post("http://localhost:3001/api/v1/auth/sign_in",
    {  
      // email: `${email}`,
      // password: `${password}`
      email: "vcvc5525@yahoo.co.jp",
      password: "password",
    },
    {
      headers: {
        contentType: "application/json"
      }
    }).then((res) => {
      if (res.data) {
        setAuth(<Auth>res.headers);
        setLoginUser(res.data.data);
        navigate("/home");
      } else {
        alert("ユーザーが見つかりません");
      }
    })
    .catch(() => alert("ログインできません"))
  }, [navigate]);

  const logout = useCallback(() => {
    axios.delete("http://localhost:3001/api/v1/auth/sign_out", config)
    .catch(() => {});
    setAuth(null);
    setLoginUser(null);
    navigate("/home")
  }, [navigate]);

  return { login, logout, setLoginUser };
}

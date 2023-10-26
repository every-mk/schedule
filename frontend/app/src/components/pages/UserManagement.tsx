import { memo, FC } from "react";

import { useLoginUser } from "../../hooks/useLoginUser";

export const UserManagement: FC = memo(() => {
  const { loginUser } = useLoginUser();
  // console.log(loginUser);
  return <p>ユーザー管理ページです</p>;
})

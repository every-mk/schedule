import { memo, FC } from "react";

import { useLoginUser } from "../../hooks/useLoginUser";

export const Home: FC = memo(() => {
  const { loginUser } = useLoginUser();
  // console.log(loginUser);
  return <p>ホームページです</p>;
});

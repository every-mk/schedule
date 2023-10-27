import { memo, FC, useState, ChangeEvent,  } from "react";
import styled from "styled-components";

import { PrimaryButton } from "../organisms/atoms/button/PrimaryButton";
import { useAuth } from "../../hooks/useAuth";

export const Login: FC = memo(() => {
  const { login } = useAuth();
  const [email, setEMail] = useState("");
  const [password, setPassword] = useState("");

  const onChangeEMail = (e: ChangeEvent<HTMLInputElement>) => setEMail(e.target.value);
  const onChangePassword = (e: ChangeEvent<HTMLInputElement>) => setPassword(e.target.value);

  const onClickLogin = () => login(email, password);

  return (
    <SContainer>
      <SFlexBox>
        <STitle>ログイン</STitle>
        <SFlexItem>
          <SLabel>メールアドレス</SLabel>
          <SInputItem>
            <SInput type="email" placeholder="mail@example.com" autoComplete="email" value={email} onChange={onChangeEMail} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <SLabel>パスワード</SLabel>
          <SInputItem>
            <SInput type="password" autoComplete="password" value={password} onChange={onChangePassword} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <PrimaryButton disabled={email === "" || password === ""} onClick={onClickLogin}>ログイン</PrimaryButton>
        </SFlexItem>
      </SFlexBox>
    </SContainer>
  );
});

const SContainer = styled.div`
  display: flex;
  height: 95vh;
  justify-content: center;
  align-items: center;
  text-align: center;
`

const SFlexBox = styled.div`
  border-radius: 10px;
  background-color: #fff;
`

const STitle = styled.h1`
  padding-bottom: 20px;
  margin: 20px;
  font-size: 24px;
  border-bottom: solid 2px #eee;
`

const SLabel = styled.label`
  display: block;
  text-align: left;
`

const SInputItem = styled.div`
  text-align: left;
`

const SInput = styled.input`
  padding: 5px;
  width: 100%;
  font-size: 18px;
`

const SFlexItem = styled.div`
  margin: 20px 70px;
  text-align: center;
`

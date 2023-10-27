import { memo, FC, useState, ChangeEvent } from "react";
import styled from "styled-components";

import { PrimaryButton } from "../organisms/atoms/button/PrimaryButton";
import { useAuth } from "../../hooks/useAuth";
import { ErrorMessage } from "../organisms/layout/ErrorMessage";

export const Signup: FC = memo(() => {
  const { signup, errorMessages } = useAuth();
  const onClickSignup = () => signup(name, email, password, passwordConfirm);
  const [name, setName] = useState("");
  const [email, setEMail] = useState("");
  const [password, setPassword] = useState("");
  const [passwordConfirm, setPasswordConfirm] = useState("");

  const onChangeName = (e: ChangeEvent<HTMLInputElement>) => setName(e.target.value);
  const onChangeEMail = (e: ChangeEvent<HTMLInputElement>) => setEMail(e.target.value);
  const onChangePassword = (e: ChangeEvent<HTMLInputElement>) => setPassword(e.target.value);
  const onChangePasswordConfirm = (e: ChangeEvent<HTMLInputElement>) => setPasswordConfirm(e.target.value);

  const isDisabled = () => {
    return name === "" || email === "" || password === "" ||
      passwordConfirm === "" || password !== passwordConfirm;
  }

  return (
    <SContainer>
      <ErrorMessage errorMessages={errorMessages} />
      <SFlexBox>
        <STitle>新規登録</STitle>
        <SFlexItem>
          <SLabel>ユーザー名</SLabel>
          <SInputItem>
            <SInput type="name" placeholder="山田 太郎" value={name} onChange={onChangeName} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <SLabel>メールアドレス</SLabel>
          <SInputItem>
            <SInput type="email" placeholder="mail@example.com" autoComplete="email" value={email} onChange={onChangeEMail} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <SLabel>パスワード</SLabel>
          <SInputItem>
            <SInput type="password" value={password} onChange={onChangePassword} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <SLabel>確認用パスワード</SLabel>
          <SInputItem>
            <SInput type="password" value={passwordConfirm} onChange={onChangePasswordConfirm} />
          </SInputItem>
        </SFlexItem>
        <SFlexItem>
          <PrimaryButton disabled={isDisabled()} onClick={onClickSignup}>登録</PrimaryButton>
        </SFlexItem>
      </SFlexBox>
    </SContainer>
  )
});

const SContainer = styled.div`
  display: flex;
  height: 95vh;
  flex-flow: column;
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

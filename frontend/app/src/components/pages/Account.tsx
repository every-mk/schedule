import { memo, FC, useCallback } from "react";
import styled from "styled-components";

import { useLoginUser } from "../../hooks/useLoginUser";
import { useNavigate } from "react-router";

export const Account: FC = memo(() => {
  const { loginUser } = useLoginUser();
  const navigate = useNavigate();
  const onClickNameEdite = useCallback(() => navigate("/account/nameEdite"), []);
  const onClickPasswordEdite = useCallback(() => navigate("/account/passwordEdite"), []);

  return (
    <SContainer>
      <SFlexBox>
        <STitle>ユーザー設定</STitle>
        <SFlexItem>
          <SLabel>ユーザー名: {loginUser?.name}</SLabel>
          <SLink onClick={onClickNameEdite}>ユーザー名の変更</SLink>
        </SFlexItem>
        <SFlexItem>
          <SLabel>メールアドレス: {loginUser?.email}</SLabel>
        </SFlexItem>
        <SFlexItem>
          <SLabel>パスワード</SLabel>
          <SLink onClick={onClickPasswordEdite}>パスワードの変更</SLink>
        </SFlexItem>
      </SFlexBox>
    </SContainer>
  )
})

const SContainer = styled.div`
  display: flex;
  height: 95vh;
  flex-flow: column;
  justify-content: center;
  align-items: center;
  text-align: center;
`

const SFlexBox = styled.div`
  padding: 0 40px;
  width: 500px;
  border-radius: 10px;
  background-color: #fff;
`

const STitle = styled.h1`
  padding-bottom: 20px;
  margin: 20px;
  font-size: 24px;
  border-bottom: solid 2px #eee;
`

const SFlexItem = styled.div`
  margin: 20px 0;
  padding-bottom: 20px;
  text-align: right;
  border-bottom: solid #eee;

  &:last-child {
    padding-bottom: 0;
    border-bottom: none;
  }
`

const SLabel = styled.label`
  display: block;
  margin-bottom: 10px;
  text-align: left;
`

const SInput = styled.input`
  padding: 5px;
  width: 100%;
  font-size: 18px;
`

const SLink = styled.a`
  border-bottom: solid #333;
  text-align: right;

  &:hover {
    cursor: pointer;
    color: #888;
    border-bottom: solid #888;
  }
`

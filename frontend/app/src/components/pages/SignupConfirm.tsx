import { memo, FC, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import styled from "styled-components";

export const SignupConfirm: FC = memo(() => {
  const navigate = useNavigate();
  const onClickHome = useCallback(() => navigate("/home"), []);

  return (
    <SContainer>
      <SFlexBox>
        <STitle>登録確認</STitle>
        <SFlexItem>
          <p>登録確認メール送信しましたので承認してください。</p>
        </SFlexItem>
        <SFlexItem>
          <SHome onClick={onClickHome}>ホーム画面へ遷移する</SHome>
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

const SFlexItem = styled.div`
  margin: 20px 70px;
  text-align: center;

  &:last-child {
    margin-top: 100px;
  }
`
const SHome = styled.a`
  border-bottom: solid #333;

  &:hover {
    cursor: pointer;
    color: #888;
    border-bottom: solid #888;
  }
`

import { memo, FC } from "react";
import styled from "styled-components";
import { useDisclosure } from "@chakra-ui/react";

import { ActiveWhiteColor, WhiteColor, HeaderHeight } from "./GlobalStyle";
import { MenuIconButton } from "../atoms/button/MenuIconButton";
import { MenuDrawer } from "../../molecules/MenuDrawer";

export const Header: FC = memo(() => {
  const { isOpen, onOpen, onClose } = useDisclosure();

  return (
    <SHeader>
      <SFlexBox>
        <SFlexItem>
          スケジュールアプリ
        </SFlexItem>
        <SFlexItemRight>
          <SFlexRightItem>設定</SFlexRightItem>
          <SSignUpButton>新規登録</SSignUpButton>
          <SLogInButton>ログイン</SLogInButton>
        </SFlexItemRight>
        <SFlexItemRight>
          <MenuIconButton onOpen={onOpen} />
        </SFlexItemRight>
      </SFlexBox>
      <MenuDrawer onClose={onClose} isOpen={isOpen} />
    </SHeader>
  );
});

const FontSize = "18px";

const SHeader = styled.header`
  padding: 5px 0;
  height: ${ HeaderHeight };
  background-color: #0033ff;
  font-size: ${ FontSize };
  color: ${ WhiteColor };
`

const SFlexBox = styled.div`
  display: flex;
  height: 100%;
`

const SFlexItem = styled.div`
  text-align: center;
  line-height: ${ HeaderHeight };

  &:hover{
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }
`

const SFlexItemRight = styled.div`
  display: flex;
  margin-left: auto;
  // display: none;

  @media(max-width: 480px) {
    display: none;
  }

  &:last-child {
    display: none;

    @media (max-width: 480px) {
      display: flex;
    }
  }
`

const SFlexRightItem = styled.div`
  margin-right: 10px;
  padding: 0 10px;
  text-align: center;
  line-height: ${ HeaderHeight };
  font-size: ${ FontSize };

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }
`

const SButton = styled.button`
  margin-right: 10px;
  padding: 0 10px;
  text-align: center;
  line-height: ${ HeaderHeight };
  font-size: ${ FontSize };
  color: ${ WhiteColor };
  border-radius: 20px;

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }
`

const SSignUpButton = styled(SButton)`
  background-color: #ff9900;
  border: solid 2px #ff8800;

  &:hover {
    background-color: #ffaa11;
  }

  &:active {
    background-color: #ff9900;
  }
`

const SLogInButton = styled(SButton)`
  background-color: #0099ff;
  border: solid 2px #0088dd;

  &:hover {
    background-color: #11aaff;
  }

  &:active {
    background-color: #0099ff;
  }
`

const HamburgerButton = styled.div`
  margin-right: 10px;
  padding-top: 5px;
  line-height: ${ HeaderHeight };
  font-size: 2em;

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }
`

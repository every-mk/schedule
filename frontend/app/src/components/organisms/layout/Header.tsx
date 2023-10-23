import { memo, FC } from "react";
import styled from "styled-components";
import { GiHamburgerMenu } from "react-icons/gi";
import { DrawerCloseButton, Button, Drawer, DrawerOverlay, DrawerContent, DrawerBody, useDisclosure, IconButton } from "@chakra-ui/react";

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
          <HamburgerButton onClick={onOpen}>
            <GiHamburgerMenu />
          </HamburgerButton>
          
        </SFlexItemRight>
      </SFlexBox>

      <Button aria-label="メニュー" size="sm" variant="unstyled" display={{ base: "block", md: "none" }} onClick={onOpen} />
      
      <Drawer placement="top" size="md" onClose={onClose} isOpen={isOpen}>
        <DrawerOverlay />
        <DrawerContent>
        <DrawerCloseButton />
          <DrawerBody>
            <Button>TOP</Button>
            <Button>ユーザー一覧</Button>
            <Button>設定</Button>
          </DrawerBody>
        </DrawerContent>
      </Drawer>
    </SHeader>
  );
});

const Height = "60px";
const FontSize = "18px";
const Color = "#fff";
const ActiveColor = "#ddd";

// ハンバーガーアイコン追加 react-icons

const SHeader = styled.header`
  padding: 5px 0;
  height: ${ Height };
  background-color: #0033ff;
  font-size: ${ FontSize };
  color: ${ Color };
`

const SFlexBox = styled.div`
  display: flex;
  height: 100%;
`

const SFlexItem = styled.div`
  text-align: center;
  line-height: ${ Height };

  &:hover{
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveColor };
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
  line-height: ${ Height };
  font-size: ${ FontSize };

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveColor };
  }
`

const SButton = styled.button`
  margin-right: 10px;
  padding: 0 10px;
  text-align: center;
  line-height: ${ Height };
  font-size: ${ FontSize };
  color: ${ Color };
  border-radius: 30px;

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveColor };
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
  line-height: ${ Height };
  font-size: 2em;

  &:active {
    color: ${ ActiveColor };
  }
`

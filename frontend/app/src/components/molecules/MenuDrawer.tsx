import { memo, FC } from "react";
import { DrawerCloseButton, Button, Drawer, DrawerOverlay, DrawerContent, DrawerBody } from "@chakra-ui/react";

import { useLoginUser } from "../../hooks/useLoginUser";
import { useAuth } from "../../hooks/useAuth";

type Props = {
  onClose: () => void;
  isOpen: boolean;
  onClickHome: () => void;
  onClickUserManagement: () => void;
  onClickLogin: () => void;
};

export const MenuDrawer: FC<Props> = memo((props) => {
  const { onClose, isOpen, onClickHome, onClickUserManagement, onClickLogin } = props;
  const { loginUser } = useLoginUser();
  const { logout } = useAuth();

  return (
    <Drawer placement="right" size="md" onClose={onClose} isOpen={isOpen}>
      <DrawerOverlay />
      <DrawerContent>
      <DrawerCloseButton />
        <DrawerBody>
          <Button onClick={onClickHome}>TOP</Button>
          {
            loginUser === null
              ? <>
                  <Button>新規登録</Button>
                  <Button onClick={onClickLogin}>ログイン</Button>
                </>
              : <>
                  <Button onClick={onClickUserManagement}>設定</Button>
                  <Button onClick={logout}>ログアウト</Button>
                </>
          }
        </DrawerBody>
      </DrawerContent>
    </Drawer>
  );
});

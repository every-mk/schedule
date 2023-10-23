import { memo, FC } from "react";
import { DrawerCloseButton, Button, Drawer, DrawerOverlay, DrawerContent, DrawerBody } from "@chakra-ui/react";

type Props = {
  onClose: () => void;
  isOpen: boolean;
};

export const MenuDrawer: FC<Props> = memo((props) => {
  const { onClose, isOpen } = props;

  return (
    <Drawer placement="right" size="md" onClose={onClose} isOpen={isOpen}>
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
  );
});

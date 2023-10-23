import { memo, FC } from "react";
import styled from "styled-components";
import { GiHamburgerMenu } from "react-icons/gi";

import { ActiveWhiteColor, HeaderHeight } from "../../layout/GlobalStyle";

type Props = {
  onOpen: () => void;
};

export const MenuIconButton: FC<Props> = memo((props) => {
  const { onOpen } = props;

  return (
    <HamburgerButton onClick={onOpen}>
      <GiHamburgerMenu />
    </HamburgerButton>
  );
});

const HamburgerButton = styled.div`
  margin-right: 10px;
  padding-top: 2px;
  line-height: ${ HeaderHeight };
  font-size: 1.4em;

  &:hover {
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }
`

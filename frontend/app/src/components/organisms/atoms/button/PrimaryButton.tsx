import { memo, FC, ReactNode } from "react";
import styled from "styled-components";

import { WhiteColor, ActiveWhiteColor } from "../../layout/GlobalStyle";

type Props = {
  children: ReactNode;
  disabled?: boolean;
  onClick: () => void;
};

export const PrimaryButton: FC<Props> = memo((props) => {
  const { children, disabled = false, onClick } = props;
  return (
    <SLogInButton disabled={disabled} onClick={onClick}>
      {children}
    </SLogInButton>
  );
});

const SLogInButton = styled.button`
  margin-left: 10px;
  padding: 10px 80px;
  border: solid 2px #02c8a8;
  border-radius: 5px;
  background-color: #03c9a9;
  color: ${ WhiteColor };

  &:hover{
    cursor: pointer;
  }

  &:active {
    color: ${ ActiveWhiteColor };
  }

  &:disabled {
    background-color: #33f9d9;
    color: ${ WhiteColor };
  }
`

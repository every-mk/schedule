import { memo, FC } from "react";
import styled from "styled-components";

type Props = {
  errorMessages: []
}

export const ErrorMessage: FC<Props> = memo((props) => {
  const { errorMessages } = props;

  if (errorMessages.length !== 0)
    {
      return (
        <SFlexBox>
          <ul>
          {
            errorMessages.map((msg, index) => (
              <li key={index}>{msg}</li>
            ))
          }
        </ul>
      </SFlexBox>
      );
    }

    return <></>;
});

const SFlexBox = styled.div`
  margin-bottom: 20px;
  padding: 20px;
  border-radius: 10px;
  background-color: #fff;
  text-align: left;
`

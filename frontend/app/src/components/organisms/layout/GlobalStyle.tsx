import { createGlobalStyle } from "styled-components";

export const GlobalStyle = () => {
  return <Style />
}

export const HeaderHeight = "30px";
export const WhiteColor = "#fff";
export const ActiveWhiteColor = "#ddd";

const Style = createGlobalStyle`
  body {
    margin: 0;
    padding: 0;
    color: #333;
  }

  header, footer, div, ul, li {
    margin: 0;
    padding: 0;
  }

  ul {
    list-style: none;
  }
`

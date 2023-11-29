import styled from "styled-components";

const PageLayout = styled.section`
  padding: 0 ${(props) => props.paddingValue}rem;

  //box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
  background-color: #f5f7fa;
`;
export default PageLayout;
import React, { useEffect, useState } from "react";
import Header from "../components/Header.jsx";
import PageLayout from "../components/PageLayout.js";
import styled, { useTheme } from "styled-components";
import { useNavigate } from "react-router-dom";

const LoginForm = styled.form`
  display: flex;
  flex-direction: column;
  align-items: center;

  input {
    margin-bottom: 40px;
    padding: 8px;
    width: 400px;
    height: 25px;
  }

  button {
    background-color: #3A923D;
    color: #fff;
    width: 420px;
    height: 50px;
    padding: 10px;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    border: none;
  }
`;

const CenteredContainer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
`;

const LoginFormContainer = styled.div`
  background-color: #ffffff;
  padding: 65px;
  border-radius: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
`;

const LoginPage = () => {
  const navigate = useNavigate();
  const [inputValue, setInputValue] = useState({
    id: "",
    password: "",
  });

  const inputChangeHandler = (e, name) => {
    const { value } = e.target;

    setInputValue((prevInputValue) => ({
      ...prevInputValue,
      [name]: value,
    }));
  };
  return (
    <PageLayout>
      <CenteredContainer>
        <h1
          style={{ fontSize: "55px", marginBottom: "60px", marginTop: "-60px" }}
        >
          로그인
        </h1>
        <LoginFormContainer>
          <LoginForm>
            <input
              type="text"
              placeholder="아이디"
              required
              name="userId"
              value={inputValue.id}
              onChange={(e) => inputChangeHandler(e, "id")}
            />
            <input
              type="text"
              placeholder="전화번호"
              required
              name="userPhoneNumber"
              value={inputValue.password}
              onChange={(e) => inputChangeHandler(e, "userPhoneNumber")}
            />
            <button type="submit">로그인</button>
          </LoginForm>
        </LoginFormContainer>
      </CenteredContainer>
    </PageLayout>
  );
};

export default LoginPage;
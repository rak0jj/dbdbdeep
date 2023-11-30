import React, { useState } from "react";
import Header from "../components/Header.jsx";
import PageLayout from "../components/PageLayout.js";
import styled, { useTheme } from "styled-components";
import { useNavigate } from "react-router-dom";
import "react-datepicker/dist/react-datepicker.css";

const SignupForm = styled.form`
  display: flex;
  flex-direction: column;
  align-items: flex-start;


  label {
    margin-bottom: 5px;
    margin-top: 20px;
    text-align: left;
    width: 100%;
    box-sizing: border-box;
    font-weight: bold;
  }

  input {
    padding: 8px;
    box-sizing: border-box;
    width: 80%;
  }

  button {
    background-color: #3A923D;
    color: #fff;
    width: 440px;
    height: 50px;
    padding: 10px;
    cursor: pointer;
    border: none;
    margin-top: 20px;
  }

  .container {
    display: flex;
    align-items: center;
    width: 100%;
    margin-bottom: -20px;
    margin-top: -15px;
  }

  .doublecheck-button {
    background-color: #f5f7fa;
    color: #3A923D;
    padding: 5px 8px;
    cursor: pointer;
    border: none;
    font-weight: bold;
    width: 80px;
    height: 30px;
    border-radius: 5px;
    margin-bottom: 20px;
    margin-left: 10px;
  }
`;

const CenteredContainer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
`;

const SignupFormContainer = styled.div`
  background-color: #ffffff;
  padding: 35px 40px;
  border-radius: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
  margin: 20px 0;
  width: 520px;
`;

const AgreementContainer = styled.div`
  display: flex;
  align-items: center;

  label {
    white-space: nowrap;
    margin-top: -0.1px;
  }
`;

const SignupPage = () => {
  const navigate = useNavigate();
  const [inputValue, setInputValue] = useState({
    userNumber: "",
    employeeNumber: "",
    department: "",
    userId: "",
    password: "",
    userName: "",
    birthDate: "",
    userEmail: "",
    userPhoneNumber: "",
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
          style={{ fontSize: "40px", marginBottom: "25px", marginTop: "55px" }}
        >
          가입하기
        </h1>
        <SignupFormContainer>
          <SignupForm>
            <label> 아이디</label>
            <div className="container">
              <input
                type="id"
                required
                name="userId"
                value={inputValue.userId}
                onChange={(e) => inputChangeHandler(e, "userId")}
              />
              <button className="doublecheck-button" type="button">
                중복확인
              </button>
            </div>

            <label>이름</label>
            <input
              type="text"
              required
              name="userName"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "userName")}
            />

            <label>성별</label>
            <input
              type="text"
              required
              name="userSex"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "userSex")}
            />

            <label>나이</label>
            <input
              type="text"
              required
              name="userAge"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "userAge")}
            />

            <label>신장</label>
            <input
              type="text"
              required
              name="userHeight"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "userHeight")}
            />

            <label>전화번호</label>
            <input
              type="text"
              required
              name="usePhoneNumber"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "usePhoneNumber")}
            />

            <label>주소</label>
            <input
              type="text"
              required
              name="userAddress"
              value={inputValue.name}
              onChange={(e) => inputChangeHandler(e, "userAddress")}
            />

            <div style={{ marginBottom: "30px" }}></div>

            <AgreementContainer>
              <input type="checkbox" id="agree" />
              <label htmlFor="agree">개인정보 수집 동의</label>
            </AgreementContainer>

            <button type="submit">가입하기</button>
          </SignupForm>
        </SignupFormContainer>
      </CenteredContainer>
    </PageLayout>
  );
};

export default SignupPage;
import axios from "axios";
import React, { useEffect, useRef, useState } from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import styled from "styled-components";
import PageLayout from "../components/PageLayout";

const Frame = styled.div`
  width: 100vw;
  height: 100vh;
`;
const HomePage = () => {
  return (
    <PageLayout>
      <Frame>
        <div className="home">
          <div className="home-main">
            <h1 className="home-main-title">데이터베이스 13팀</h1>
            <h1 className="home-main-content">스포츠팀 매칭 서비스</h1>
            <p className="13team">장락영, 백명준, 김세아</p>
          </div>
        </div>
      </Frame>
    </PageLayout>
  );
};

export default HomePage;
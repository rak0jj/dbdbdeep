import axios from "axios";
import React, { useEffect, useRef, useState } from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import styled from "styled-components";

import BasicList from '../components/BasicList'; 
import PageLayout from "../components/PageLayout";

const Frame = styled.div`
  width: 100vw;
  height: 100vh;
`;

const MatchPage = () => {
  return (
    <PageLayout>
      <Frame>
        <div className="match">
          <div className="match-main">
            <h1 className="match-main-title">🔎 매치 찾기</h1>
            <p className="match-main-sub">마음에 드는 경기를 찾아보세요!</p>
          </div>
          <BasicList />
        </div>
      </Frame>
    </PageLayout>
  );
};

export default MatchPage;
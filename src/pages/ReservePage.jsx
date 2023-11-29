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
const ReservePage = () => {
  return (
    <PageLayout>
      <Frame>
        <div className="reserve">
          <div className="reserve-main">
            <h1 className="reserve-main-title">🗓️ 구장 예약</h1>
            <BasicList />
          </div>
        </div>
      </Frame>
    </PageLayout>
  );
};

export default ReservePage;
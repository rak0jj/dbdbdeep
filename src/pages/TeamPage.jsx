import axios from "axios";
import React, { useEffect, useRef, useState } from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import styled from "styled-components";

import PageLayout from "../components/PageLayout";

const Frame = styled.div`
  width: 100vw;
  height: 100vh;
`;
const TeamPage = () => {
  return (
    <PageLayout>
      <Frame>
        <div className="team">
          <div className="team-main">
            <h1 className="team-main-title">💡내 팀 찾기</h1>
          </div>
        </div>
      </Frame>
    </PageLayout>
  );
};

export default TeamPage;
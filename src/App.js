import logo from "./logo.svg";
import "./App.css";
import React from "react";
import { Route, Routes, BrowserRouter, Link } from "react-router-dom";

import Button from "@mui/material/Button";
import Header from "./components/Header";
import PageLayout from "./components/PageLayout";

import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import MatchPage from "./pages/MatchPage";
import ReservePage from "./pages/ReservePage";
import SignupPage from "./pages/SignupPage";
import TeamPage from "./pages/TeamPage";

function App() {
  return (
    <>
      <BrowserRouter>
        <Header>
          <div className="menu">
            <div className="menu-bar">
              <Link to="/" className="menu-home-item">
                13팀
              </Link>
              <Link to="/match" className="menu-bar-item">
                매치 찾기
              </Link>
              <Link to="/reserve" className="menu-bar-item">
                구장 예약
              </Link>
              <Link to="/team" className="menu-bar-item">
                내 팀 찾기
              </Link>
            <Link to="/login" className="menu-bar-button">
                <Button variant="contained" style={{background: "#f5f7fa", color: "#3A923D", fontWeight: "bold", boxShadow: "none", marginLeft: "10px"}} >
                  로그인
                </Button>
              </Link>
              <Link to="/signup" className="menu-bar-button">
              <Button variant="contained" style={{ background: "#3A923D", fontWeight: "bold", boxShadow: "none", marginLeft: "10px"}} >
                  회원가입
                </Button>
              </Link>
              </div>
          </div>
        </Header>
        <Routes>
          <Route path="/" element={<HomePage />} />{" "}
          <Route path="/login" element={<LoginPage />} />
          <Route path="/match" element={<MatchPage />} />
          <Route path="/reserve" element={<ReservePage />} />
          <Route path="/signup" element={<SignupPage />} />
          <Route path="/team" element={<TeamPage />} />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
import React from 'react'
import InputCardDeck from "./InputCardDeck";
import SideNavPane from "./SideNavPane";
import {BrowserRouter as Router, Route} from 'react-router-dom'
import DarkModeToggle from "../DarkThemeComponent/DarkModeToggle";
import DarkTheme from 'react-dark-theme'

const lightTheme = {
  background: 'white',
  text: 'black',
}

const darkTheme = {
  background: 'black',
  text: 'white',
}

const AppManager = () => {
  return (
    <Router>
      <div className="container-fluid">
        <h1 className="code"> Quick Scripts</h1>
        <DarkTheme light={lightTheme} dark={darkTheme} />
        <br/>
        <div className="sidenav">
          <SideNavPane />
          {/*<Route path="/"*/}
          {/*       component={SideNavPane}>*/}
          {/*</Route>*/}
        </div>
        <div className="content">
          {/*<InputCardDeck/>*/}
          <Route path="/script/:scriptId"
                 component={InputCardDeck}>
          </Route>
        </div>
      </div>
    </Router>
  )
}

const AppManager1 = () => {
  return (
    <div>
      <div className="container-fluid">
        <h1 className="code">Quick Scripts</h1>
        <DarkTheme light={lightTheme} dark={darkTheme} />
        <br/>
        <SideNavPane/>
        {/*<InputCardDeck/>*/}
      </div>
    </div>
  )
}

export default AppManager

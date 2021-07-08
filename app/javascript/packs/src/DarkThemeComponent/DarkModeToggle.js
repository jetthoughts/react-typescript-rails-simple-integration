// import React, {useState} from "react";
// import DarkModeToggle from "react-dark-mode-toggle";
//
// export default () => {
//     const [isDarkMode, setIsDarkMode] = useState(() => false);
//     return (
//         <DarkModeToggle
//             onChange={setIsDarkMode}
//             checked={isDarkMode}
//             size={80}
//         />
//     );
// };

import React from 'react'

import DarkTheme from 'react-dark-theme'

// const lightTheme = {
//   background: 'white',
//   text: 'black',
// }
//
// const darkTheme = {
//   background: 'black',
//   text: 'white',
// }

// https://www.smashingmagazine.com/2020/04/dark-mode-react-apps-styled-components/
export const lightTheme = {
  body: '#FFF',
  text: '#363537',
  toggleBorder: '#FFF',
  background: '#363537',
}
export const darkTheme = {
  body: '#363537',
  text: '#FAFAFA',
  toggleBorder: '#6B8096',
  background: '#999',
}

export default class DarkModeToggle extends React.Component {
  render() {
    return (
      <div>
        <DarkTheme light={lightTheme} dark={darkTheme}/>
        Rest of your application
      </div>
    )
  }
}

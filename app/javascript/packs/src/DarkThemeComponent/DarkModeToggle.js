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

const lightTheme = {
    background: 'white',
    text: 'black',
}

const darkTheme = {
    background: 'black',
    text: 'white',
}

export default class DarkModeToggle extends React.Component {
    render() {
        return (
            <div>
                <DarkTheme light={lightTheme} dark={darkTheme} />
                Rest of your application
            </div>
        )
    }
}

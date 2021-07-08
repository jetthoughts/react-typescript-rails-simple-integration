import React, { useState } from "react";
// import { mount } from '../packs/application';
import { mount } from '../application';
import AppManager from '../src/containers/AppManager'
import 'bootstrap/dist/css/bootstrap.css'
import 'font-awesome/css/font-awesome.min.css'
import 'bootstrap/dist/js/bootstrap.js'
import './style.css'
import 'rsuite/dist/styles/rsuite-default.css';
import '@trendmicro/react-sidenav/dist/react-sidenav.css';

interface AppProps {
  message: string
}

export const App: React.FC<AppProps> = ({message}) => {
  const [inp, setInp] = useState("kod")
  const [hist, setHist] = useState([])
  const assignChange = (e) => {
    // e => setInp(e.value)
    const val = e.target.value
    setInp(val)
    setHist([...hist, val])
    // setHist(hist + val) // implicit type error
    // console.log(hist)
    // console.log(typeof hist)
    // hist.map(h => console.log(h))
  }
  return (
    // <div>
    //   <button onClick={() => alert(message)}>
    //     alert message from props!
    //   </button>
    //   <div>
    //     <input id={"txt"} onChange={assignChange} placeholder={inp}/>
    //     <p id={"out"}>{inp}</p>
    //     <p id={"outlist2"}>{hist.join(", ")}</p>
    //     // hist list
    //     <div id={"outlist"}>
    //       {hist.map((h,i) => <p key={i}>{h}</p>)}
    //     </div>
    //   </div>
    // </div>
      <AppManager />

  )
}

mount(App, 'app');

// export default App;

import React from 'react';
import ReactDOM from 'react-dom';
// import {App} from "../src/App";
// import {App} from "./src/App";

export function mount(Component, mountNodeId) {
  document.addEventListener('DOMContentLoaded', () => {
    const mountNode = document.getElementById(mountNodeId);
    const propsJSON = mountNode.getAttribute('data-react-props');
    const props = JSON.parse(propsJSON);

    // ReactDOM.render(<AppManager/>, document.getElementById(root));
    // ReactDOM.render(<Component props={props}/>, mountNode);
    ReactDOM.render(<Component {...props} />, mountNode);
  })
}

// mount(App, 'app');

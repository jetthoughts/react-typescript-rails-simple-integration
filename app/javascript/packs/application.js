import React from 'react';
import ReactDOM from 'react-dom';

export function mount(Component, mountNodeId) {
  document.addEventListener('DOMContentLoaded', () => {
    const mountNode = document.getElementById(mountNodeId);
    const propsJSON = mountNode.getAttribute('data-react-props');
    const props = JSON.parse(propsJSON);

    ReactDOM.render(<Component {...props} />, mountNode);
  })
}

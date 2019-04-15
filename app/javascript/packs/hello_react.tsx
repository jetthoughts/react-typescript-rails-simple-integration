// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react';
import ReactDOM from 'react-dom';

interface WelcomeProps {
  message: string
}

export const Welcome: React.FC<WelcomeProps> = ({ message }) => (
  <button onClick={() => alert(message)}>
    Click on me!
  </button>
)

const mountNode = document.getElementById('welcome-button');
const message = mountNode.getAttribute('data-message');
document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Welcome message={message} />,
    mountNode,
  )
})

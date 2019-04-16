import React from 'react';
import { mount } from './application';

interface WelcomeProps {
  message: string
}

export const Welcome: React.FC<WelcomeProps> = ({ message }) => (
  <button onClick={() => alert(message)}>
    Click on me!
  </button>
)

mount(Welcome,'welcome-button');

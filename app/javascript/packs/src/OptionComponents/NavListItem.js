import React from 'react';
import {Icon, Nav} from 'rsuite';
import { LinkContainer } from 'react-router-bootstrap'

export default class NavListItem
    extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <LinkContainer to={`/script/${this.props.scriptId}`}>
                <Nav.Item eventKey={this.props.scriptId} icon={<Icon icon="dashboard" />}>
                    {this.props.scriptName}
                </Nav.Item>
            </LinkContainer>
        );
    }
}

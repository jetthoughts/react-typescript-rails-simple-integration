import React from 'react';
import { Sidenav, Toggle, Icon, Nav } from 'rsuite';
import AppService from "../services/AppService";
import NavListItem from "../OptionComponents/NavListItem";

export default class SideNavPane
    extends React.Component {
    constructor() {
        super();
        this.AppService = AppService.instance;
        this.state = {
            expanded: true,
            activeKey: '',
            scripts:[]
        };
        this.handleToggle = this.handleToggle.bind(this);
        this.handleSelect = this.handleSelect.bind(this);
    }
    handleToggle() {
        this.setState({
            expanded: !this.state.expanded
        });
    }
    handleSelect(eventKey) {
        this.setState({
            activeKey: eventKey
        });
    }

    componentDidMount() {
        this.AppService.findAllScripts().then(({scripts})=>{
            console.log("SideNavPane: ",scripts)
            this.setState({scripts:scripts})
        })
    }

    scriptItems() {
        // var scriptItems = this.state.scripts.map(script => {
            // return<NavListItem key={script.id} scriptName={script.title} scriptId={script.id}/>
        var scriptItems = this.state.scripts.map((script,i) => {
            return <NavListItem key={i} scriptName={script} scriptId={script}/>
        })
        return(scriptItems)
    }

    render() {
        const { expanded } = this.state;
        return (
            <div>
                <Toggle checkedChildren={<Icon icon="check" />} unCheckedChildren={<Icon icon="close" />} onChange={this.handleToggle} checked={expanded} />
                <hr />
                <Sidenav
                    expanded={expanded}
                    // defaultOpenKeys={['3', '4']}
                    activeKey={this.state.activeKey}
                    onSelect={this.handleSelect}
                >
                    <Sidenav.Body>
                        <Nav>
                            {this.scriptItems()}
                        </Nav>
                    </Sidenav.Body>
                </Sidenav>
            </div>
        );
    }
}

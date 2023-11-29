import * as React from 'react';
import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Divider from '@mui/material/Divider';
import useMediaQuery from '@mui/material/useMediaQuery';

export default function BasicList() {
  const matches = useMediaQuery('(min-width:600px)');

  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <Box sx={{ width: matches ? '80%' : 600, maxWidth: 900, bgcolor: 'background.paper' }}>
        <nav aria-label="main">
          <List>
            <ListItem disablePadding sx={{ height: 100 }}>
              <ListItemButton>
                <ListItemIcon>
                </ListItemIcon>
                <ListItemText primary="대구 북구 A구장" />
              </ListItemButton>
            </ListItem>
            <ListItem disablePadding sx={{ height: 100 }}>
              <ListItemButton>
                <ListItemIcon>
                </ListItemIcon>
                <ListItemText primary="서울 영등포구 M구장" />
              </ListItemButton>
            </ListItem>
          </List>
        </nav>
        <Divider />
      </Box>
    </div>
  );
}

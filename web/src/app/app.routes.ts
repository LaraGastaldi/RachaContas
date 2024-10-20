import { Routes } from '@angular/router';
import { VerifyComponent } from './verify/verify.component';

export const routes: Routes = [
    { path: '/verify/:code', component: VerifyComponent, title: 'Valide sua dívida' }
];

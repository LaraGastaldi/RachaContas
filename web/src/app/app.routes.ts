import { Routes } from '@angular/router';
import { NotFoundComponent } from './not-found/not-found.component';
import { VerifyComponent } from './verify/verify.component';

export const routes: Routes = [
    { path: 'verify/:id', component: VerifyComponent },
    { path: '**', component: NotFoundComponent }
];

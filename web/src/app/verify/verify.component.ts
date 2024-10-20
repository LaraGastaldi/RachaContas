import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { UserToDebtService } from '../services/user-to-debt.service';
import { switchMap } from 'rxjs';

@Component({
  selector: 'app-verify',
  standalone: true,
  imports: [],
  templateUrl: './verify.component.html',
  styleUrl: './verify.component.css'
})
export class VerifyComponent {
  debtInfo: any;

  constructor(public route: ActivatedRoute, public service: UserToDebtService) {
    this.debtInfo = this.route.paramMap.pipe(
      switchMap(params => {
        const activationCode = params.get('code');
        if (!activationCode) {
          return null;
        }
        return this.service.getDebtInfo(activationCode);
      })
    );
  }
}

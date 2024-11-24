import { Component, Inject } from '@angular/core';
import { VerifyService } from '../verify-service.service';
import { ActivatedRoute } from '@angular/router';

@Inject(VerifyService)
@Component({
  selector: 'app-verify',
  standalone: true,
  imports: [],
  templateUrl: './verify.component.html',
  styleUrl: './verify.component.css'
})
export class VerifyComponent {

  code: string|null = null;

  constructor(public service: VerifyService, private route: ActivatedRoute) {
    try {
      this.code = this.route.snapshot.params['id'];
      if (!this.code) {
        throw new Error('Invalid code');
      }
    } catch (e) {
      window.location.href = '/404';
      return;
    }

    this.service.verify(this.code)
      .subscribe(
        res => {
          console.log(res);
        },
        err => {
          console.error(err);
        }
      );
  }
}

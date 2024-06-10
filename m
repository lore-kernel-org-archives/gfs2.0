Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C67E767
	for <gfs2@lists.linux.dev>; Mon, 10 Jun 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029048; cv=none; b=iKgyT5+OpmHofrPGlw22DDI/55ZUZ0p4ELf2TEjSI0SystlVfbrSkRmNxpAZcPeuVAoLTNMqkuCCx9gbmPmdOTHYQX6j0YEQNHWqR9u2B2sJG9E8jYqiIVRUuGsGUb1GWlxMWbw5KTTuJnViWLSOnKqCI8C1aznurw2/J5pSBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029048; c=relaxed/simple;
	bh=witgDr4/dJHGtjNydpq7rvXtrgLEr20TZ9umaz90Scc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zh92hgy1urjc+AeEO85eMxmapvjBgbSQC5CvpwWLFnIhetdvNOTSNQCJjXfYkhLp+6DonIEqKWDF+xnEi8mulyQV8EHu3W006dBtHgHFPst3hbTv74Sk0P7EjBppPwKRkwYy1bK2FJ/gzRHTVkjXftZewOzeYgt/ikMhUw77Skk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DH+pQAPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH+pQAPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718029046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=witgDr4/dJHGtjNydpq7rvXtrgLEr20TZ9umaz90Scc=;
	b=DH+pQAPeW+YcJEzo1CNq2S8DqTPOeTKXzpcZiaRBpLRu90HMLj0ifgUxzdVCjhRZbnyWbV
	HpIANn6rH7rSmXiil1K5sJOHMXSYpZeY2AdGASmvkGqrJjdhWSferI6I9DggkijYXfUreN
	8HMu/uPn68w/94B+tHXb/QL+15A1isw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-c-fpDT1oPm6Ovy_psb-TGg-1; Mon, 10 Jun 2024 10:17:24 -0400
X-MC-Unique: c-fpDT1oPm6Ovy_psb-TGg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd7ad3476so13643201fa.2
        for <gfs2@lists.linux.dev>; Mon, 10 Jun 2024 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029043; x=1718633843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=witgDr4/dJHGtjNydpq7rvXtrgLEr20TZ9umaz90Scc=;
        b=CvAAaXawX1JvtCE2iVxK4C3t2qeAVU4/YZ7HCrNYf9fXUgRmLZ1dYJ5Hgv9/Hbi4sT
         bST94s4HtXoPzpH3vW8thWII4GY/LBxxho+HHyVorzel1CfFeNHGE7WDoIuLkay9yMEI
         T7foP71I1UI/U6aIQeW6KZrGR2TOpe0AbpqNnL9UqRihQlLdctNNoXkQyCNUZsYoORf2
         HcCBh84oBt/Yg0WjT2fEmqmYrrYXQFrPHxFqgR9XZOAt9+2WYwO1EOCVZzs6GUKWy2I5
         OCJa3pw/9J+frKyLPura5ymww0h8CH9MCuce+kPOIwmcdWozpwoGqR5xE8IapAPZIRja
         B+Xg==
X-Gm-Message-State: AOJu0YxP5F8aS1Pv6YHEYU5rwU4dRoXG35yJYGaMk7LMVS4viJlpcQKq
	56mftgAY3ubJNe1q4Fyx3iSn5u5amU2Knzut/9sV6TjU0AJBrt/8NFSkig6+JY+EOR6E1PGSRS+
	yXxRXBxvZJgZTo+tK7nkqVdv1XgkcBniX48lcW/zx45kfH58usYpRZ1IpXcjLUrCEFcrdolOpMQ
	ckMKQH7V4rzxQB4VKHM6yF3GHE9A==
X-Received: by 2002:a2e:9216:0:b0:2eb:d92c:58f8 with SMTP id 38308e7fff4ca-2ebd92c5b1emr31516341fa.19.1718029042757;
        Mon, 10 Jun 2024 07:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwmgL9HRoSiNinc9IFG7zhtdoItvWRDTikkFEM4XBA388KgAHS+Ve9n6NSjG9HsrZgeQrp1X7tWOrZR/zT4aI=
X-Received: by 2002:a2e:9216:0:b0:2eb:d92c:58f8 with SMTP id
 38308e7fff4ca-2ebd92c5b1emr31516141fa.19.1718029042405; Mon, 10 Jun 2024
 07:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240603215558.2722969-1-aahringo@redhat.com> <20240603215558.2722969-3-aahringo@redhat.com>
In-Reply-To: <20240603215558.2722969-3-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 10 Jun 2024 10:17:10 -0400
Message-ID: <CAK-6q+gCkJyDhqxpRw_TKO1fHshnx5+oRjQrB_LeY+RE7SuKRA@mail.gmail.com>
Subject: Re: [PATCH dlm/next 2/8] dlm: remove struct field with the same meaning
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev, song@kernel.org, yukuai3@huawei.com, 
	linux-raid@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, Jun 3, 2024 at 5:56=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> There is currently "res_nodeid" and "res_master_nodeid" fields in
> "struct dlm_rsb". At some point a developer does not know when to use
> which one or forget to update one and they are out of sync. This patch
> removes the "res_nodeid" and allows "res_master_nodeid" only. They have
> different representation values about their invalid values, the
> "res_master_nodeid" seems to be the modern way of represent the actual
> master nodeid and actually use the nodeid value when the own nodeid is
> the master (on res_nodeid the 0 represented this value). Also the modern
> nodeid representation fits into a "unsigned" range as this avoids to
> convert negative values over the network. The old value representation
> is still part of the DLM networking protocol that's why the conversion
> functions dlm_res_nodeid() and dlm_res_master_nodeid() are still
> present. On a new major DLM version bump protocol the nodeid representati=
on
> should be updated to the modern value representation. These conversion
> functions also applies for existing UAPI and the user space still
> assumes the old "res_nodeid" value representation.
>
> The same arguments applies to "lkb_nodeid" and "lkb_master_nodeid"
> wheras this is also only a copied value from another lkb related field
> "lkb_resource" and it's "res_master_nodeid" value. In this case it
> requires more code review because "lkb_resource" is not set sometimes.
>
> This patch so far makes the code easier to read and understandable
> because we don't have several fields with the same meaning in some
> structs. In case of the previously "res_nodeid" value, sometimes an
> additional check on our_nodeid() is required to set the value to 0 that
> represents in this value representation that we are the master node.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

__dlm_master_lookup() returns "-1" (the old value representation for
invalid nodeid) and it should return 0 for invalid now.
Also we forgot dlm_send_rcom_lookup()/receive_rcom_lookup() to update
using the conversion functions.

- Alex

